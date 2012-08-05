class TwitterController < ApplicationController
  @count=0
  def index
   @handle= params[:handle]
   @handle||=""
   puts "Handle"+@handle
   @x=getCloud(@handle)
   puts @count
  end

  def getCloud(username)

  options= {}
  options["count"]=1000
  options["include_rts"]=true
  options["page"]=1
  options["exclude_replies"]=true

    begin
      user=Twitter.user(username)
      puts "Status Count "+user.status_count.to_s
      np = ([1000, user.status_count].min/200.0).ceil
      puts "Number of pages"+np.to_s
      count=0
      wc={}
      (1..np).each do |page_number|
        options["page"]=page_number
        all=Twitter.user_timeline(username,options )
        puts "Fetching page #{page_number}"
        count+=all.size.to_i
          all.each do |stat|
            text=stat.text.split.size
            wc[text]||=0
            wc[text]+=1
          end if !all.nil?
        sleep 1 # pause for a couple seconds
      end
      @count=count
      puts  "Fetched #{count}"
      wc.to_a.sort!

    rescue Twitter::Error::NotFound =>e
      return {}
    end

  end



end
