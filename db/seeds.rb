require 'open-uri'

Line.all.each do |line|
  line.destroy
end
Station.all.each do |station|
  station.destroy
end

# Blue
color = '#3857a6'
line = Line.create(name: 'Blue', color: color)
station_names = [
  'Wonderland',
  'Revere Beach',
  'Beachmont',
  'Suffolk Downs',
  'Orient Heights',
  'Wood Island',
  'Airport',
  'Maverick',
  'Aquarium',
  'State Street',
  'Government',
  'Bowdoin'
]
station_names.each_with_index do |val, i|
  station = Station.find_or_create_by(name: val)
  LinesStation.create(line: line, station: station, station_sequence: i)
end

##! MBTA updated the stations table to a react component.
##! needs to integrate Watir to get JavaScript-enabled HTML

# # Orange
# line_name = 'Orange'
# color = '#ed8422'
# url = "https://www.mbta.com/schedules_and_maps/subway/lines/?route=#{line_name.upcase}"
# doc = Nokogiri::HTML(open(url,
#   'User-Agent' => "Ruby/#{RUBY_VERSION}",
#   'From' => 'foo@bar.invalid',
#   'Referer' => 'https://www.ruby-lang.org/'))
# station_names = []
# doc.css('td a').each do |a|
#   if a.attributes['title']
#     station_names << a.attributes['title'].value
#   end
# end
# station_names.map! { |name| name.sub(/ Station/, '') }
#
# line = Line.create(name: line_name, color: color)
# station_names.each_with_index do |val, i|
#   station = Station.find_or_create_by(name: val)
#   LinesStation.create(line: line, station: station, station_sequence: i)
# end

# # Red
# url = 'https://www.mbta.com/schedules_and_maps/subway/lines/?route=RED'
# doc = Nokogiri::HTML(open(url,
#   'User-Agent' => "Ruby/#{RUBY_VERSION}",
#   'From' => 'foo@bar.invalid',
#   'Referer' => 'https://www.ruby-lang.org/'))
# station_names = []
#
# doc.css('td a').each do |a|
#   if a.attributes['title']
#     station_names << a.attributes['title'].value
#   end
# end
# station_names.map! { |name| name.sub(/ Station/, '') }
#
# color = '#cf4335'
# line = Line.create(name: 'Red(Braintree)', color: color)
# braintree = station_names.index('Braintree')
# b_stations = station_names[0..braintree]
#
# b_stations.each_with_index do |val, i|
#   station = Station.find_or_create_by(name: val)
#   LinesStation.create(line: line, station: station, station_sequence: i)
# end
#
# line = Line.create(name: 'Red(Ashmont)', color: color)
# n_quincy = station_names.index('North Quincy')
# last = station_names.length
# a_stations = station_names[0...n_quincy] + station_names[(braintree + 1)..last]
#
# a_stations.each_with_index do |val, i|
#   station = Station.find_or_create_by(name: val)
#   LinesStation.create(line: line, station: station, station_sequence: i)
# end

# # Green
# line_name = 'Green'
# color = '#416f3f'
# url = "https://www.mbta.com/schedules_and_maps/subway/lines/?route=#{line_name.upcase}"
# doc = Nokogiri::HTML(open(url,
#   'User-Agent' => "Ruby/#{RUBY_VERSION}",
#   'From' => 'foo@bar.invalid',
#   'Referer' => 'https://www.ruby-lang.org/'))
# g_stations = []
# doc.css('td a').each do |a|
#   if a.attributes['title']
#     g_stations << a.attributes['title'].value
#     break if a.attributes['title'].value == 'Kenmore Station'
#   end
# end
# g_stations.map! { |name| name.sub(/ Station/, '') }
# park = g_stations.index('Park Street')
# north = g_stations.index('North')
# copley = g_stations.index('Copley')
#
# line = Line.create(name: line_name + ' B', color: color)
# b_stations = [
#   'Blandford Street',
#   'Boston University East',
#   'Boston University Central',
#   'Boston University West',
#   'St. Paul',
#   'Pleasant Street',
#   'Babcock Street',
#   'Packards Corner',
#   'Harvard Avenue',
#   'Griggs Street/Long Avenue',
#   'Allston Street',
#   'Warren Street',
#   'Washington Street',
#   'Sutherland Road',
#   'Chiswick Road',
#   'Chestnut Hill Avenue',
#   'South Street',
#   'Boston College'
# ]
# b_stations = g_stations[park..last] + b_stations
# b_stations.each_with_index do |val, i|
#   station = Station.find_or_create_by(name: val)
#   LinesStation.create(line: line, station: station, station_sequence: i)
# end
#
# line = Line.create(name: line_name + ' C', color: color)
# c_stations = [
#   'St. Marys Street',
#   'Hawes Street',
#   'Kent Street',
#   'St. Paul Street',
#   'Coolidge Corner',
#   'Summit Avenue',
#   'Brandon Hall',
#   'Fairbanks',
#   'Washington Square',
#   'Tappan Street',
#   'Dean Road',
#   'Englewood Avenue',
#   'Cleveland Circle'
# ]
# c_stations = g_stations[north..last] + c_stations
# c_stations.each_with_index do |val, i|
#   station = Station.find_or_create_by(name: val)
#   LinesStation.create(line: line, station: station, station_sequence: i)
# end
#
# line = Line.create(name: line_name + ' D', color: color)
# d_stations = [
#   'Fenway',
#   'Longwood',
#   'Brookline Village',
#   'Brookline Hills',
#   'Beaconsfield',
#   'Reservoir',
#   'Chestnut Hill',
#   'Newton Centre',
#   'Newton Highlands',
#   'Eliot',
#   'Waban',
#   'Woodland',
#   'Riverside'
# ]
# d_stations = g_stations[park..last] + d_stations
# d_stations.each_with_index do |val, i|
#   station = Station.find_or_create_by(name: val)
#   LinesStation.create(line: line, station: station, station_sequence: i)
# end
#
# line = Line.create(name: line_name + ' E', color: color)
# e_stations = [
#   'Prudential',
#   'Symphony',
#   'Northeastern University',
#   'Museum of Fine Arts',
#   'Longwood Medical Area',
#   'Brigham Circle',
#   'Fenwood Road',
#   'Mission Park',
#   'Riverway',
#   'Back of the Hill',
#   'Heath Street'
# ]
# e_stations = g_stations[0..copley] + e_stations
# e_stations.each_with_index do |val, i|
#   station = Station.find_or_create_by(name: val)
#   LinesStation.create(line: line, station: station, station_sequence: i)
# end
