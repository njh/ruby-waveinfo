$:.unshift(File.dirname(__FILE__))

require 'spec_helper'
require 'waveinfo'


describe WaveInfo do

  describe "parsing a Mono 11kHz PCM file with no 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_16bit_pcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(1)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('PCM')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(1)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(11025)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(22050)
    end
    
    it "should get the block align value right" do
      expect(@wav.block_align).to eq(2)
    end
    
    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(16)
    end
    
    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(8820)
    end
    
    it "should get the number of samples right" do
      expect(@wav.samples).to eq(4410)
    end

    it "should get the audio duration right" do
      expect(@wav.duration).to eq(0.4)
    end
    
    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing a Mono 8kHz GSM file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_8k_mono_gsm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(49)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('GSM')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(1)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(8000)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(1625)
    end
    
    it "should get the block align value right" do
      expect(@wav.block_align).to eq(65)
    end
    
    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(0)
    end
    
    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(650)
    end
    
    it "should get the number of samples right" do
      expect(@wav.samples).to eq(3200)
    end

    it "should get the audio duration right" do
      expect(@wav.duration).to eq(0.4)
    end
    
    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing a Stereo 44.1kHz 16-bit PCM file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('testcase_44k_stereo_16bit_pcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(1)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('PCM')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(2)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(44100)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(176400)
    end
    
    it "should get the block align value right" do
      expect(@wav.block_align).to eq(4)
    end
    
    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(16)
    end
    
    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(100000)
    end
    
    it "should get the number of samples right" do
      expect(@wav.samples).to eq(25000)
    end

    it "should get the audio duration right" do
      expect((@wav.duration * 1000).to_i).to eq(566)
    end
    
    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing a Mono 11kHz Microsoft ADPCM file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_ms_adpcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(2)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('Microsoft ADPCM')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(1)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(11025)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(5784)
    end
    
    it "should get the block align value right" do
      expect(@wav.block_align).to eq(128)
    end
    
    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(4)
    end
    
    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(2432)
    end
    
    it "should get the number of samples right" do
      expect(@wav.samples).to eq(4410)
    end

    it "should get the audio duration right" do
      expect(@wav.duration).to eq(0.4)
    end
    
    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing a Mono 11kHz 8-bit PCM file with no 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_8bit_pcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(1)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('PCM')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(1)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(11025)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(11025)
    end
    
    it "should get the block align value right" do
      expect(@wav.block_align).to eq(1)
    end
    
    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(8)
    end
    
    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(4410)
    end
    
    it "should get the number of samples right" do
      expect(@wav.samples).to eq(4410)
    end

    it "should get the audio duration right" do
      expect(@wav.duration).to eq(0.4)
    end
    
    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing a Mono 11kHz a-law file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_alaw')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(6)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('a-law')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(1)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(11025)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(11025)
    end
    
    it "should get the block align value right" do
      expect(@wav.block_align).to eq(1)
    end
    
    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(8)
    end
    
    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(4410)
    end
    
    it "should get the number of samples right" do
      expect(@wav.samples).to eq(4410)
    end

    it "should get the audio duration right" do
      expect(@wav.duration).to eq(0.4)
    end
    
    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing a Mono 11kHz u-law file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_ulaw')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(7)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('u-law')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(1)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(11025)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(11025)
    end
    
    it "should get the block align value right" do
      expect(@wav.block_align).to eq(1)
    end
    
    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(8)
    end
    
    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(4410)
    end
    
    it "should get the number of samples right" do
      expect(@wav.samples).to eq(4410)
    end

    it "should get the audio duration right" do
      expect(@wav.duration).to eq(0.4)
    end
    
    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing a Mono 11kHz IMA ADPCM file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_ima_adpcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(17)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('IMA ADPCM')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(1)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(11025)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(5589)
    end
    
    it "should get the block align value right" do
      expect(@wav.block_align).to eq(256)
    end
    
    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(4)
    end
    
    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(2304)
    end
    
    it "should get the number of samples right" do
      expect(@wav.samples).to eq(4410)
    end

    it "should get the audio duration right" do
      expect(@wav.duration).to eq(0.4)
    end
    
    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing a Stereo 96kHz 24bit RF64" do
    before :each do
      @filepath = sample_path('empty_96k_stereo_24bit_rf64')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      expect(@wav.audio_format_id).to eq(65534)
    end

    it "should get the audio format name right" do
      expect(@wav.audio_format).to eq('Extensible wave format')
    end

    it "should get the number of channels right" do
      expect(@wav.channels).to eq(2)
    end

    it "should get the sample rate right" do
      expect(@wav.sample_rate).to eq(96000)
    end

    it "should get the byte rate right" do
      expect(@wav.byte_rate).to eq(576000)
    end

    it "should get the block align value right" do
      expect(@wav.block_align).to eq(6)
    end

    it "should get the bits per sample right" do
      expect(@wav.bits_per_sample).to eq(24)
    end

    it "should get the audio length in bytes right" do
      expect(@wav.size).to eq(4294967295)
    end

    it "should get the number of samples right" do
      expect(@wav.samples).to eq(715827882)
    end

    it "should get the audio duration right" do
      expect(@wav.duration).to eq(7456.5404375)
    end

    it "should know the name of the file read from" do
      expect(@wav.filename).to eq(File.basename(@filepath))
    end
  end

  describe "parsing an invalid WAVE file" do
    it "should throw an exception if the first chunk id isn't 'RIFF'" do
      data = StringIO.new("INVALID")
      expect { WaveInfo.new( data ) }.to raise_error(WaveInfo::FileFormatError)
    end

    it "should throw an exception if the chunk format isn't 'WAVE'" do
      data = StringIO.new("RIFF\0\0\0\0INVALID")
      expect { WaveInfo.new( data ) }.to raise_error(WaveInfo::FileFormatError)
    end

    it "should not throw an exception if WAVE file is valid but has no sub-chunks" do
      data = StringIO.new("RIFF\4\0\0\0WAVE")
      expect { WaveInfo.new( data ) }.not_to raise_error
    end
    
    it "should set the audio format name to Unknown for an unknown audio codec" do
      data = StringIO.new("RIFF\x14\0\0\0WAVEfmt \x0a\0\0\0\xff\x00\x02\0\0\0\0\0\0\0\0\0\0\0\0\0")
      expect(WaveInfo.new( data ).audio_format).to eq('Unknown (0xff)')
    end
  end
end
