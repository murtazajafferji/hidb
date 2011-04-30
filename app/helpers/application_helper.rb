# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper	
  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                        'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                        'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                        'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                        'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' +
                        'mobile'
  def get_string_array_of_words_for_js
  	words = Word.all
  	words.map! do |w|
  		w.name
  	end
  	return words.to_json
  end
  
  def get_string_array_of_users_for_js
  	users = User.all
  	names = users.map {|u| u.name}
  	logins = users.collect {|u| u.login}
  	users = names + logins
  	users.compact!
  	users.uniq!
  	return users.to_json
  end
  
  def sort_url key, val
    newparams = params.dup
    newparams[key] = val
    url_for(newparams)
  end
  
  def itemize_type types
  	string = ""
  	if types.length == 2
  		string = types[0] + " " + "and" + " " + types[1]
  	else
 	  types.each_with_index do |type, index|
 	    if index < (types.length - 2)
 	      string += type + ", "
 	    elsif index == types.length - 2
 	      string += type + ", " + "and" + " "
 	    else
 	  	  string += type
 	    end
 	  end
 	end
 	string
  end
  
  def is_mobile_device?
    request.user_agent.to_s.downcase =~ Regexp.new(MOBILE_USER_AGENTS)
  end
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def google_pie_chart(data, options = {})
    options[:width] ||= 250
    options[:height] ||= 100
    #options[:colors] = %w(0DB2AC F5DD7E FC8D4D FC694D FABA32 704948 968144 C08FBC ADD97E)
    if options[:type] == "negative"
      options[:colors] = %w(292C37 57493C 9F111B)
    elsif options[:type] == "like"
      options[:colors] = %w(2cda0b e31b1b)
    else
      options[:colors] = %w(26ADE4 EB6841 DD2C7F)
    end
    dt = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-."
    options[:divisor] ||= 1

    while (data.map { |k,v| v }.max / options[:divisor] >= 4096) do
      options[:divisor] *= 10
    end

    opts = {
      :cht => "p",
      :chd => "e:#{data.map{|k,v|v=v/options[:divisor];dt[v/64..v/64]+dt[v%64..v%64]}}",
      :chdl => "#{data.map { |k,v| CGI::escape(k + " (#{v})")}.join('|')}",
      :chs => "#{options[:width]}x#{options[:height]}",
      :chco => options[:colors].slice(0, data.length).join(','),
      :chf => "bg,s,FFFFFF00",
      :chdlp => "r",
      :chdls => "FFFFFFFF,8",
      #:chdls => "000000,8",
    }

    image_tag("http://chart.apis.google.com/chart?#{opts.map{|k,v|"#{k}=#{v}"}.join('&')}")
  rescue
  end
  
  def button(*args)
    if args.size == 3
      name = args[0]
      url = args[1]
      _class = args[2]
      content_tag :button, :type => "button", :class => _class, :onclick => "window.location.href =  '#{url_for(url)}'; " do
        "#{name}"
      end
    elsif args.size == 2
      name = args[0]
      url = args[1]
      content_tag :button, :type => "button", :onclick => "window.location.href =  '#{url_for(url)}'; " do
        "#{name}"
      end
    elsif args.size == 1
      name = args[0]
      content_tag :button, :type => "button" do
        "#{name}"
      end
    end
  end
  
  # number_to_percentage(0, :precision => 2)
  def number_to_percentage(number, options = {})
    options   = options.stringify_keys
    precision = options["precision"] || 3
    separator = options["separator"] || "."
    begin
      number = number_with_precision(number, precision)
      parts = number.split('.')
      if parts.at(1).nil?
        parts[0] + "%"
      else
        parts[0] + separator + parts[1].to_s + "%"
      end
    rescue
      number
    end
  end
  
  def number_with_precision(number, precision=3)
    "%01.#{precision}f" % ((Float(number) * (10 ** precision)).round.to_f / 10 ** precision)
  rescue
    number
  end
  
  def sort_url key, val
    newparams = params.dup
    newparams[key] = val
    url_for(newparams)
  end
  
  # creates an html table with tr and td tags by passing in args. 
  # Each row is an array.
  # The first gets th tags unless :th=>false is specified
  # options: The last item may be an options hash.  The options 
  # :tr, :td, and :table allow insertion of arbitrary attributes 
  # into the html of their respective tags.
  # If there are rows with too few items the columns are printed as  

  # <%= table(
  # ['first','last'],
  # ['johan','smith'],
  # ['jim','jorgenson'], {:th=>false, :table=>"class='datagrid'", :tr=>"border='10'"}) %>
  
  require "lib/array.rb"
  def table(*args)
   opts=args.last.is_a?(Hash) ? args.delete_at(args.length - 1) : {}
   rows=args
   [:table,:tr,:td].each {|sym| opts[sym]= " #{opts[sym]} " if opts[sym]}
   maxcols = rows.inject(0) {|memo,row| row.length > memo ? row.length : memo  }
   rows.map {|row|(maxcols-row.length).times{ row << "& nbsp;"};row }
   rows=rows.map{|row| row.sandwich("\t\t<td#{opts[:td]}>","</td>\n") }
   rows[0].gsub!('td','th') unless opts[:th] == false
   return ("<table#{opts[:table]}>\n" + rows.sandwich("\t<tr#{opts[:tr]}>\n","\t</tr>\n") + "</table>\n")
  end

end
