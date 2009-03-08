$:.unshift(File.dirname(__FILE__))

require 'spec_helper'
require 'waveinfo'


describe WaveInfo do

  describe "parsing a Mono 11kHz PCM file with no 'fact' chunk" do
    before :each do
      @filepath = fixture_path('sine')
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
  end

  describe "parsing a Mono 8kHz GSM file with a 'fact' chunk" do
    before :each do
      @filepath = fixture_path('sine_gsm')
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
  end
end
