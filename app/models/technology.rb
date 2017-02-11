class Technology < ApplicationRecord
  before_save :generate_token

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  private

  def generate_token
    self.token = StringTokenizer.tokenize(name)
  end
end
