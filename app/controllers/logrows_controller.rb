require "pdf/writer"
require 'pdf/simpletable'
require 'csv'
class LogrowsController < ApplicationController
#	in_place_edit_for_all :logrow, :remarks
	auto_complete_for_all :logrow, :aircraft_ident, :remarks

	def load_my_info
	  	session[:page] ||= 1				#If nothing in session, store 1.
	  	params[:page] ||= session[:page]	#If nothing in params, use session.
	  	session[:page] = params[:page]		#Then save current in session.
	  	@userlogbook = Userlogbook.find(current_user)
		@per_page = 10
		@pdf_size_multiplier = 28
		load_table_info 		# loads @col_order, @field_map, @title_rec, @blank_rec, @numeric_col #See application.rb
	end

	def load_rows
		load_my_info
	    @logrows = Logrow.paginate_by_userlogbook_id @userlogbook.id,
							    				:page => params[:page],
							    				:order => 'flt_date ASC',
							    				:per_page => @per_page
		@allrows = Logrow.find_all_by_userlogbook_id @userlogbook.id
		row_totals(@logrows, @page_totals)								#See application.rb
		row_totals(@allrows, @grand_totals)
	end

  # GET /logrows
  # GET /logrows.xml
	def index
		load_rows
	    respond_to do |format|
	    	format.html # index.html.erb
	    	format.xml  { render :xml => @logrows }
	    end
	end

  #GET /logrows/csv
	def csv
		load_rows
		build_csv
		send_data(@csv_out, :type => 'text/csv', :filename => "mylogbook.csv")
	end

  #GET /logrows/pdf
	def pdf
		if params[:blank]
			load_my_info
			@logrows = []
			@allrows = []
		else
			load_rows
		end
		(@per_page - @logrows.size).times do 		#Make all pages same size
			@logrows << @blank_rec
		end
		_pdf = PDF::Writer.new(:orientation => :landscape)
		build_pdf(_pdf)													#See application.rb
		send_data _pdf.render,	:filename => "Logbook.pdf", :type => "application/pdf"
	end

  # GET /logrows/1
  # GET /logrows/1.xml
  def show
    @logrow = Logrow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @logrow }
    end
  end

  # GET /logrows/new
  # GET /logrows/new.xml
  def new
    @logrow = Logrow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @logrow }
    end
  end

  # GET /logrows/1/edit
  def edit
    @logrow = Logrow.find(params[:id])
  end

  # POST /logrows
  # POST /logrows.xml
  def create
  	load_my_info
    @logrow = Logrow.new(params[:logrow])
	@logrow.userlogbook_id = @userlogbook.id

    respond_to do |format|
      if @logrow.save
        flash[:notice] = 'Logrow was successfully created.'
        format.html { redirect_to(logrows_url) }
        format.xml  { render :xml => @logrow, :status => :created, :location => @logrow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @logrow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /logrows/1
  # PUT /logrows/1.xml
  def update
  	load_my_info
    @logrow = Logrow.find(params[:id])
	@logrow.userlogbook_id = @userlogbook.id

    respond_to do |format|
      if @logrow.update_attributes(params[:logrow])
        flash[:notice] = 'Logrow was successfully updated.'
        format.html { redirect_to(logrows_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @logrow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /logrows/1
  # DELETE /logrows/1.xml
  def destroy
    @logrow = Logrow.find(params[:id])
    @logrow.destroy

    respond_to do |format|
      format.html { redirect_to(logrows_url) }
      format.xml  { head :ok }
    end
  end
end
