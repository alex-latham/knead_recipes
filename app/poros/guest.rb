class Guest
  attr_reader :name, :username, :restriction_list
  def initialize(name='guest_user', username='guest_username')
    @name = name
    @username = username
    @restriction_list = []
  end
end
