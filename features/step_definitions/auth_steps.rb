Given('I test embassy timeslots') do
  @browser.navigate.to 'https://booking.timerise.io/service/58hcCrqGvhSEFv9XoTli?lang=ua'
  while allocate_available_slots > 0
    wait(300) # wait for 5 minutes
    @browser.navigate.refresh
  end
  File.write('timetracker.txt', Time.now)
  select_last_slot
end

def select_last_slot
  slot = @browser.find_element(:xpath, "//div[text()='19 серп.']/../../*/*/span[text()=\"11:15\"]")
  slot.click
  slot.click
  name = @browser.find_element(:css, 'input#fullName')
  email = @browser.find_element(:css, 'input#email')
  telephone = @browser.find_element(:xpath, "//label[@for='phone-number-select']/../div/input")
  button = @browser.find_element(:css, "button[type=submit]")
  name.send_keys(ENV['NAME'])
  telephone.send_keys(ENV['TELEPHONE'])
  email.send_keys(ENV['EMAIL'])
  wait 1
  button.click
end

def allocate_available_slots
  wait(20)
  next_chevron_btn = @browser.find_element(:css, 'svg.icon.icon-tabler.icon-tabler-chevron-right')
  next_chevron_btn.click
  next_chevron_btn.click
  wait(10)
  spans = @browser.find_elements(:xpath, "//div[text()='20 серп.']/../../*/*/span[text()=\"-\"]")
  spans.count
end

def wait(sec)
  begin
    wait = Selenium::WebDriver::Wait.new(:timeout => sec)
    wait.until { |_s| false }
  rescue StandardError => e
    puts e
  end
end
