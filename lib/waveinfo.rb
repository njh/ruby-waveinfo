#!/usr/bin/env ruby

class WaveInfo

  # Set WaveInfo.debug = false to suppress warning messages.
  class << self
    attr_accessor :debug
  end
  self.debug = true

  # Create a new WaveInfo object to get information and metadata about a
  # Wave file (.wav). 'file' can either be a filename or an IO object.
  def initialize(file)

    # Set default values
    @audio_format_id = 0
    @bits_per_sample = nil
    @block_align = nil
    @byte_rate = nil
    @channels = nil
    @data_size = nil
    @sample_rate = nil
    @samples = nil

    # What was passed in to us?
    if file.is_a?(String)
      @io = File.new(file, 'rb')
      @filepath = @io.path
      read_headers
      @io.close
    else
      @io = file
      @filepath = @io.path if @io.respond_to?(:path)
      read_headers
    end
  end

  # Return the name of the input file.
  def filename
    File.basename(@filepath)
  end

  # Get the identifier of the audio codec (for example PCM would be 1).
  def audio_format_id
    @audio_format_id
  end

  # Get the name of the audio codec (for example 'PCM').
  def audio_format
    case @audio_format_id
      when 0x01 then
        "PCM"
      when 0x02 then
        "Microsoft ADPCM"
      when 0x06 then
        "a-law"
      when 0x07 then
        "u-law"
      when 0x11 then
        "IMA ADPCM"
      when 0x14 then
        "G.723"
      when 0x31 then
        "GSM"
      when 0x40 then
        "G.721"
      when 0x50 then
        "MPEG-1 Audio"
      when 0x55 then
        "MPEG Audio Layer 3"
      when 0xFFFE
        "Extensible wave format"
      else
        sprintf("Unknown (0x%2.2x)",@audio_format_id)
    end
  end

  # Get the number of channels.
  def channels
    @channels
  end

  # Get the sample rate (in Hz).
  def sample_rate
    @sample_rate
  end

  # Get the average number of bytes per second.
  def byte_rate
    @byte_rate
  end

  # Get the number of bytes per sample slice.
  def block_align
    @block_align
  end

  # Get the number of bits per sample.
  def bits_per_sample
    @bits_per_sample
  end

  # Get the total number of samples.
  def samples
    if @samples
      @samples
    else
      @data_size / @block_align
    end
  end

  # Get the length of the audio data (in bytes).
  def size
    @data_size
  end

  # Get the duration of the audio (in seconds).
  def duration
    samples.to_f / sample_rate.to_f
  end

  private

  def read_headers
    # Read in the chunk header
    @chunk_id = read_fourchar
    @chunk_size = read_longint
    @chunk_format = read_fourchar
    raise FileFormatError.new("Chunk format is not 'WAVE'") unless @chunk_format == 'WAVE'

    if @chunk_id == 'RIFF'
      position = 0xC
    elsif @chunk_id == 'RF64'
      # Next sub-chunk *has* to be a 'ds64'
      subchunk_size = read_ds64_chunk
      position = 0xC + subchunk_size
    else
      raise FileFormatError.new("Primary chunk id is not 'RIFF' or 'RF64'")
    end

    read_subchunks(position)
  end

    
  def read_subchunks(position)
    # Read in each of the sub-chunks
    while(@chunk_size - position) > 0 do
      subchunk_id = read_fourchar
      subchunk_size = read_longint
      case subchunk_id
        when 'fmt '
          read_fmt_chunk(subchunk_size)
        when 'fact'
          read_fact_chunk(subchunk_size)
        when 'data'
          unless subchunk_size == 0xFFFFFFFF
          @data_size = subchunk_size
          end
          # Skip over the wave data
          @io.seek(@data_size,IO::SEEK_CUR)
        when nil
          # Give up if read fails
          $stderr.puts "Warning: read error before reaching end of file" if WaveInfo.debug
          break
        else
          pos = sprintf("0x%x", position)
          $stderr.puts "Warning: unsupported sub-chunk at #{pos}: #{subchunk_id}" if WaveInfo.debug
          @io.seek(subchunk_size,IO::SEEK_CUR)
      end
      position += subchunk_size + 8
    end

  end

  def read_fmt_chunk(size)
    @audio_format_id = read_shortint
    @channels = read_shortint
    @sample_rate = read_longint
    @byte_rate = read_longint
    @block_align = read_shortint
    @bits_per_sample = read_shortint

    # Skip any extra parameters
    @io.seek(size-16,IO::SEEK_CUR) if size > 16
  end

  def read_fact_chunk(size)
    # Read in the number of samples
    sample_count = read_longint
    unless sample_count == 0xFFFFFFFF
      @samples = sample_count
    end

    # Skip any extra data
    @io.seek(size-4,IO::SEEK_CUR) if size > 4
  end

  def read_ds64_chunk
    subchunk_id = read_fourchar
    raise FileFormatError.new("First sub-chunk of RF64 file is not 'ds64'") unless subchunk_id == 'ds64'
    subchunk_size = read_longint

    riff_size_low = read_longint
    riff_size_high = read_longint
    data_size_low = read_longint
    data_size_high = read_longint
    sample_count_low = read_longint
    sample_count_high = read_longint

    @data_size = (data_size_high << 32) + data_size_low
    @samples = (sample_count_high << 32) + sample_count_low
    @chunk_size = (riff_size_high << 32) + riff_size_low

    # Skip any extra data
    @io.seek(subchunk_size-24,IO::SEEK_CUR) if subchunk_size > 24
  end

  def read_fourchar
    @io.read(4)
  end

  def read_longint
    bytes = @io.read(4)
    bytes ? bytes.unpack('V').first : nil
  end

  def read_shortint
    bytes = @io.read(2)
    bytes ? bytes.unpack('v').first : nil
  end

  # Exception raised if there is a problem parsing the Wave file
  class FileFormatError < StandardError
  end

end
