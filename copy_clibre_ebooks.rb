str = `ls -d */`
dirs = str.split("\n")

dirs.each do |dir|
  subs = `ls "#{dir}"`.split("\n")
  subs.each do |sub|
    files = `ls "#{dir}"/"#{sub}"`.split("\n")
    epub = files.find{ |f| /\.epub/ =~ f}.gsub(/\n/, '')
    `cp "#{dir}"/"#{sub}"/"#{epub}" .`
  end
end
