class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  #from :exception to :null_session


  def add()
    code = User.add(params[:user_name], params[:password])
    data = {}
    if code >= 1
      data[:count] = code
      data[:errCode] = 1
    else
      data[:errCode] = code
    end
    render json: data
  end

  def login()
    code = User.login(params[:user_name], params[:password])
    if code >= 1
      data[:count] = code
      data[:errCode] = 1
    else
      data[:errCode] = code
    end
    render data
  end

  def TESTAPI_resetFixture()
    code = User.TESTAPI_resetFixture()
    render json: {errCode: code}
  end

  def runUnitTests()
    output = User.runUnitTests()
    last_line = output.lines.last
    last_line_captured = /(?<totalTests>\d+) examples, (?<nrFailed>\d+) failures/.match(last_line)
    totalTests = last_line_captured[:totalTests]
    nrFailed = last_line_captured[:nrFailed]
    render json: {nrFailed: nrFailed, output: output, totalTests: totalTests}
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_name, :password, :login_counter)
    end
end
