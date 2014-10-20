every 1.day, :at => '12:00 am' do
  runner "Project.update_days_left"
end