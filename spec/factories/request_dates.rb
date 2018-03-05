FactoryBot.define do

  factory :request_2_days_old_date, class: RequestDate do
    request_name "request_stations"
    date { 3.days.ago }
  end

  factory :request_2_hours_old_date, class: RequestDate do
    request_name "request_stations"
    date { 2.hours.ago }
  end

  factory :request_5_minutes_old_date, class: RequestDate do
    request_name "request_bikes"
    date { 5.minutes.ago }
  end


  factory :request_1_minute_old_date, class: RequestDate do
    request_name "request_bikes"
    date { 1.minute.ago }
  end
end
