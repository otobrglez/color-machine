require 'spec_helper'

RSpec.describe ColorsFromImage do

  let(:image_url){
    "http://muse-cdn.warnerartists.com/ugc-1/discography/discog/61/131_square.jpg"
  }

  context "just image" do
    subject { ColorsFromImage.new(image: image_url) }
    # it { expect(subject.to_css).not_to be_nil }

    it {
      puts subject.to_css
    }
  end
end
