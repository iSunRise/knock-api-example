require 'rails_helper'

RSpec.describe Technology, type: :model do
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  it 'should generate token' do
    tech = Technology.new(name: 'Caché Script 1.2')
    tech.save
    expect(tech.reload.token).to eq('cachscript12')
  end
end
