Given('I test embassy timeslots') do
  @browser.navigate.to 'https://booking.timerise.io/service/58hcCrqGvhSEFv9XoTli?lang=ua'
  unless target_slot_visible?
    wait(30) unless Time.now.hour == 2
    @browser.navigate.refresh
    puts Time.now
  end
  File.write('timetracker.txt', Time.now)
  select_last_slot
end

def select_last_slot
  slot = @browser.find_element(:xpath, "//div[text()='29 серп.']/../../*/*/span[text()=\"10:45\"]")
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

def target_slot_visible?
  begin
    wait(5)
    next_chevron_btn = @browser.find_element(:css, 'svg.icon.icon-tabler.icon-tabler-chevron-right')
    next_chevron_btn.click
    next_chevron_btn.click
    wait(5)
    spans = @browser.find_elements(:xpath, "//div[text()='29 серп.']/../../*/*/span[text()=\"-\"]")
    slot = @browser.find_element(:xpath, "//div[text()='29 серп.']/../../*/*/span[text()=\"10:45\"]")
    spans.count == 0 && slot.displayed?
  rescue
    false
  end
end

def wait(sec, el=nil)
  wait = Selenium::WebDriver::Wait.new(:timeout => sec)
  return wait.until { |_s| el.displayed? } if el

  wait.until { |_s| false }
rescue StandardError => e
  puts e
end
