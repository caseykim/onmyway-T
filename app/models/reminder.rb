class Reminder < ActiveRecord::Base
  belongs_to :user
  belongs_to :line

  validates :user, presence: true
  validates :line, presence: true
  validate :user_name_and_phone_number
  validates :line, uniqueness: {
    scope: :user,
    message: 'reminder already exists'
  }

  def remind
    @twilio_number = ENV['TWILIO_NUMBER']
    sid = ENV['TWILIO_ACCOUNT_SID']
    token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(sid, token)
    reminder = "Hi, #{user.name}.Construction on #{line.name}"
    reminder += " line will start within an hour. Visit "
    url = "http://onmyway-t.herokuapp.com/lines/#{line.id}/constructions"
    reminder += url
    reminder += " for construction details"
    message = @client.account.messages.create(
      from: @twilio_number,
      to: user.phone_number,
      body: reminder,
    )
  end

  def self.deliver_due
    time_range = Time.current.to_s(:time)..1.hour.from_now.to_s(:time)
    joins(line: :constructions).where(
      constructions: { start_time: time_range }
    ).where(
      'start_date <= ? and end_date >= ?',
      Time.zone.today,
      Time.zone.today
    )
  end

  private

  def user_name_and_phone_number
    if user.name.blank? || user.phone_number.blank?
      errors.add(:user, 'missing name and/or phone number')
    end
  end
end
