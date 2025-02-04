class User < ApplicationRecord
  before_create :confirmation_token
  before_save :encrypt_password, :check_whitelist
  has_many :donations
  has_and_belongs_to_many :events

  attr_accessor :password

  validates :email, {
    presence: true,
    uniqueness: true
  }
  validates_format_of :email, :with => /@/
  validates :username, {
    presence: true,
    uniqueness: true
  }
  validates :password, confirmation: true, if: :password_required?
  validates :password, length: { in: 6..20 }, if: :password_required?
  
  def self.check_playing
    require 'minecraft-query'
    @query = McQuery::fullQuery('localhost', 25565)
    if @query.is_a?(Hash)
      @query[:players].each do |player|
        u = User.find_by_username player
        if u
          u.played_at = Time.now
          u.save!
        end
      end
    end
  end
  
  def password_required?
    !password.blank? || encrypted_password.blank?
  end

  def self.encrypt(pass, salt)
    Digest::SHA2.hexdigest(salt+pass)
  end

  def encrypt_password
    return if password.blank?
    if new_record?
      self.salt = SecureRandom.base64(8)
    end
    self.encrypted_password = User.encrypt(password,salt)
  end

  def check_whitelist
    wl_file = "/home/minecraft/spigot/whitelist.json"
    if wl_file
      wl_string = File.read(wl_file)
      wl_hash = JSON.parse(wl_string)
      whitelist = wl_hash.map { |entry| entry["name"].downcase }
      if whitelist.include? self.username.downcase
        self.isonwhitelist = true
      else
        self.isonwhitelist = false
      end
    end
  end

  def authenticated?(pass)
    encrypted_password == User.encrypt(pass, salt)
  end

  def self.authenticate(username, pass)
    user = User.where(username: username).take
    user && user.authenticated?(pass) ? user : nil
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def generate_new_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s 
    save!(:validate => false)
  end

  def get_donations
    self.donations.order('updated_at desc')
  end
  
  private
    def confirmation_token
      if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end

end
