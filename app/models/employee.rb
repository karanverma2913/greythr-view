class Employee < User
  validates :name, :email, :password, :salary, :role, presence: true
  # validates :joining_date, format: { with: /\d{2}\/\d{2}\/\d{4}/, message: "must be in the following format: mm/dd/yyyy" }

  validates :name, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/,
    message: 'should be in characters only' }

  validates :password, length: { in: 8..15, message: 'must be between 8 to 15 characters' }

  validates :email, uniqueness: { message: 'is already exist' },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: '%<value>s not a valid email !!!' },
    exclusion: { in: %w[hr@gmail.com],
    message: '%<value>s is reserved.' }
end
