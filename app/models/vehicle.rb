class Vehicle < ActiveRecord::Base
  belongs_to :user

  validates :license, format: {with: /\A[a-zA-Z0-9]+\z/, message: "only allows Alphanumeric characters (no spaces)"}

  validates :colour, format: {with: /\A[a-zA-Z\s]+\z/, message: "only allows Alphanumeric characters (no spaces)"}

  validates :make, presence: true

  validates :year, numericality: {:only_integer => true, :allow_nil => false, :greater_than_or_equal_to => 1900},
            :length => {is: 4}

  validates_uniqueness_of :license

  def owner
    self.user
  end

  def paid?
    if self.paid == 'paid'
      return true
    else
      return false
    end
  end

  def full_info
    # puts "#{year}"
    "#{self.license}, #{self.make}, #{self.model}, #{self.colour} ,#{self.year}"
  end
end
