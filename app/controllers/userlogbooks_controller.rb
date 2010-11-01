class UserlogbooksController < ApplicationController
  # GET /userlogbooks
  # GET /userlogbooks.xml
  def index
    @userlogbooks = Userlogbook.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @userlogbooks }
    end
  end

  # GET /userlogbooks/1
  # GET /userlogbooks/1.xml
  def show
    @userlogbook = Userlogbook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userlogbook }
    end
  end

  # GET /userlogbooks/new
  # GET /userlogbooks/new.xml
  def new
    @userlogbook = Userlogbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @userlogbook }
    end
  end

  # GET /userlogbooks/1/edit
  def edit
    @userlogbook = Userlogbook.find(params[:id])
  end

  # POST /userlogbooks
  # POST /userlogbooks.xml
  def create
    @userlogbook = Userlogbook.new(params[:userlogbook])

    respond_to do |format|
      if @userlogbook.save
        flash[:notice] = 'Userlogbook was successfully created.'
        format.html { redirect_to(@userlogbook) }
        format.xml  { render :xml => @userlogbook, :status => :created, :location => @userlogbook }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @userlogbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /userlogbooks/1
  # PUT /userlogbooks/1.xml
  def update
    @userlogbook = Userlogbook.find(params[:id])

    respond_to do |format|
      if @userlogbook.update_attributes(params[:userlogbook])
        flash[:notice] = 'Userlogbook was successfully updated.'
        format.html { redirect_to(@userlogbook) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @userlogbook.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /userlogbooks/1
  # DELETE /userlogbooks/1.xml
  def destroy
    @userlogbook = Userlogbook.find(params[:id])
    @userlogbook.destroy

    respond_to do |format|
      format.html { redirect_to(userlogbooks_url) }
      format.xml  { head :ok }
    end
  end
end
