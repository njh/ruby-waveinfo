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
      @wav.audio_format_id.should == 1
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'PCM'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 1
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 11025
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 22050
    end
    
    it "should get the block align value right" do
      @wav.block_align.should == 2
    end
    
    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 16
    end
    
    it "should get the audio length in bytes right" do
      @wav.size.should == 8820
    end
    
    it "should get the number of samples right" do
      @wav.samples.should == 4410
    end

    it "should get the audio duration right" do
      @wav.duration.should == 0.4
    end
    
    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing a Mono 8kHz GSM file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_8k_mono_gsm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      @wav.audio_format_id.should == 49
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'GSM'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 1
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 8000
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 1625
    end
    
    it "should get the block align value right" do
      @wav.block_align.should == 65
    end
    
    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 0
    end
    
    it "should get the audio length in bytes right" do
      @wav.size.should == 650
    end
    
    it "should get the number of samples right" do
      @wav.samples.should == 3200
    end

    it "should get the audio duration right" do
      @wav.duration.should == 0.4
    end
    
    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing a Stereo 44.1kHz 16-bit PCM file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('testcase_44k_stereo_16bit_pcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      @wav.audio_format_id.should == 1
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'PCM'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 2
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 44100
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 176400
    end
    
    it "should get the block align value right" do
      @wav.block_align.should == 4
    end
    
    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 16
    end
    
    it "should get the audio length in bytes right" do
      @wav.size.should == 100000
    end
    
    it "should get the number of samples right" do
      @wav.samples.should == 25000
    end

    it "should get the audio duration right" do
      (@wav.duration * 1000).to_i.should == 566
    end
    
    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing a Mono 11kHz Microsoft ADPCM file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_ms_adpcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      @wav.audio_format_id.should == 2
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'Microsoft ADPCM'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 1
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 11025
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 5784
    end
    
    it "should get the block align value right" do
      @wav.block_align.should == 128
    end
    
    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 4
    end
    
    it "should get the audio length in bytes right" do
      @wav.size.should == 2432
    end
    
    it "should get the number of samples right" do
      @wav.samples.should == 4410
    end

    it "should get the audio duration right" do
      @wav.duration.should == 0.4
    end
    
    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing a Mono 11kHz 8-bit PCM file with no 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_8bit_pcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      @wav.audio_format_id.should == 1
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'PCM'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 1
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 11025
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 11025
    end
    
    it "should get the block align value right" do
      @wav.block_align.should == 1
    end
    
    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 8
    end
    
    it "should get the audio length in bytes right" do
      @wav.size.should == 4410
    end
    
    it "should get the number of samples right" do
      @wav.samples.should == 4410
    end

    it "should get the audio duration right" do
      @wav.duration.should == 0.4
    end
    
    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing a Mono 11kHz a-law file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_alaw')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      @wav.audio_format_id.should == 6
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'a-law'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 1
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 11025
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 11025
    end
    
    it "should get the block align value right" do
      @wav.block_align.should == 1
    end
    
    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 8
    end
    
    it "should get the audio length in bytes right" do
      @wav.size.should == 4410
    end
    
    it "should get the number of samples right" do
      @wav.samples.should == 4410
    end

    it "should get the audio duration right" do
      @wav.duration.should == 0.4
    end
    
    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing a Mono 11kHz u-law file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_ulaw')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      @wav.audio_format_id.should == 7
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'u-law'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 1
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 11025
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 11025
    end
    
    it "should get the block align value right" do
      @wav.block_align.should == 1
    end
    
    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 8
    end
    
    it "should get the audio length in bytes right" do
      @wav.size.should == 4410
    end
    
    it "should get the number of samples right" do
      @wav.samples.should == 4410
    end

    it "should get the audio duration right" do
      @wav.duration.should == 0.4
    end
    
    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing a Mono 11kHz IMA ADPCM file with a 'fact' chunk" do
    before :each do
      @filepath = sample_path('sine_11k_mono_ima_adpcm')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      @wav.audio_format_id.should == 17
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'IMA ADPCM'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 1
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 11025
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 5589
    end
    
    it "should get the block align value right" do
      @wav.block_align.should == 256
    end
    
    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 4
    end
    
    it "should get the audio length in bytes right" do
      @wav.size.should == 2304
    end
    
    it "should get the number of samples right" do
      @wav.samples.should == 4410
    end

    it "should get the audio duration right" do
      @wav.duration.should == 0.4
    end
    
    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing a Stereo 96kHz 24bit RF64" do
    before :each do
      @filepath = sample_path('empty_96k_stereo_24bit_rf64')
      @wav = WaveInfo.new( @filepath )
    end

    it "should get the audio format id right" do
      @wav.audio_format_id.should == 65534
    end

    it "should get the audio format name right" do
      @wav.audio_format.should == 'Extensible wave format'
    end

    it "should get the number of channels right" do
      @wav.channels.should == 2
    end

    it "should get the sample rate right" do
      @wav.sample_rate.should == 96000
    end

    it "should get the byte rate right" do
      @wav.byte_rate.should == 576000
    end

    it "should get the block align value right" do
      @wav.block_align.should == 6
    end

    it "should get the bits per sample right" do
      @wav.bits_per_sample.should == 24
    end

    it "should get the audio length in bytes right" do
      @wav.size.should == 4294967295
    end

    it "should get the number of samples right" do
      @wav.samples.should == 715827882
    end

    it "should get the audio duration right" do
      @wav.duration.should == 7456.5404375
    end

    it "should know the name of the file read from" do
      @wav.filename.should == File.basename(@filepath)
    end
  end

  describe "parsing an invalid WAVE file" do
    it "should throw an exception if the first chunk id isn't 'RIFF'" do
      data = StringIO.new("INVALID")
      lambda { WaveInfo.new( data ) }.should raise_error(WaveInfo::FileFormatError)
    end

    it "should throw an exception if the chunk format isn't 'WAVE'" do
      data = StringIO.new("RIFF\0\0\0\0INVALID")
      lambda { WaveInfo.new( data ) }.should raise_error(WaveInfo::FileFormatError)
    end

    it "should not throw an exception if WAVE file is valid but has no sub-chunks" do
      data = StringIO.new("RIFF\4\0\0\0WAVE")
      lambda { WaveInfo.new( data ) }.should_not raise_error
    end
    
    it "should set the audio format name to Unknown for an unknown audio codec" do
      data = StringIO.new("RIFF\x14\0\0\0WAVEfmt \x0a\0\0\0\xff\x00\x02\0\0\0\0\0\0\0\0\0\0\0\0\0")
      WaveInfo.new( data ).audio_format.should == 'Unknown (0xff)'
    end
  end
end
