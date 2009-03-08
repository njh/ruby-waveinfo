$:.unshift(File.dirname(__FILE__))

require 'spec_helper'
require 'waveinfo'


describe WaveInfo do

  describe "parsing a Mono 11kHz PCM file with no fact chunk" do
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
end
