#!/usr/bin/env ruby

class WaveInfo

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
      read_headers
      @io.close
    else
      @io = file
      read_headers
    end
  end
  
  # Get the identifier of the audio codec (for example PCM would be 1)
  def audio_format_id
    @audio_format_id
  end

  # Get the name of the audio codec (for example 'PCM')
  def audio_format
    case @audio_format_id
      when 1 then
        "PCM"
      when 2 then
        "Microsoft ADPCM"
      when 6 then
        "a-law"
      when 7 then
        "u-law"
      when 17 then
        "IMA ADPCM"
      when 20 then
        "G.723"
      when 49 then
        "GSM"
      when 64 then
        "G.721"
      when 80 then
        "MPEG Audio"
      else
        "Unknown (#{@audio_format_id})"
    end
  end
  
  # Get the number of channels.
  def channels
    @channels
  end

  # Get the sample rate (in Hz)
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
  
  # Get the length of the audio data (in bytes)
  def size
    @data_size
  end
  
  # Get the duration of the audio (in seconds)
  def duration
    samples.to_f / sample_rate.to_f
  end

  private

  def read_headers
    # Read in the chunk header
    chunk_id = read_fourchar
    raise FileFormatError.new("Chunk id is not 'RIFF'") if chunk_id != 'RIFF'
    chunk_size = read_longint
    chunk_format = read_fourchar
    raise FileFormatError.new("Chunk format is not 'WAVE'") if chunk_format != 'WAVE'
    
    # Read in each of the sub-chunks
    position = 0x0C
    while(chunk_size-position) > 0 do
      subchunk_id = read_fourchar
      subchunk_size = read_longint
      case subchunk_id
        when 'fmt '
          read_fmt_chunk(subchunk_size)
        when 'fact'
          read_fact_chunk(subchunk_size)
        when 'data'
          @data_size = subchunk_size
          # Skip over the wave data
          @io.seek(subchunk_size,IO::SEEK_CUR)
        else
          pos = sprintf("0x%x", position)
          $stderr.puts "Warning: unsupported sub-chunk at #{pos}: #{subchunk_id}"
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
    @io.seek(size-16,IO::SEEK_CUR)
  end
  
  def read_fact_chunk(size)
    # Read in the number of samples
    @samples = read_longint

    # Skip any extra data
    @io.seek(size-4,IO::SEEK_CUR) if size > 4
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
  class FileFormatError < Exception
  end
  
end
