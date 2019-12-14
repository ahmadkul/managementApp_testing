class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :vehicles

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :pCode, format: {with: /\A[a-zA-Z][0-9][a-zA-Z]\s[0-9][a-zA-Z][0-9]+\z/,
                             message: "[Postal Code] is not in the correct format"},
            :length => {is: 7}

  validates :telephone, numericality: {:only_integer => true},
            :length => {is: 10}

  validates :fName, :lName, presence: true

  def full_name
    self.fName + " " + self.lName
  end

  def full_address
    self.address + ',' + self.city + ',' + self.province + ',' + self.pCode
  end

  def cars_owned
    self.vehicles.each do |car|
      car.full_info
    end
  end

end
