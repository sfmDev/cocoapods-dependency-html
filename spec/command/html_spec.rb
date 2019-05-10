require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Html do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ html }).should.be.instance_of Command::Html
      end
    end
  end
end

