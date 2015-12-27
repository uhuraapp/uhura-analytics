class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy, :deliver]

  before_action :authenticate_admin!

  def index
    @letters = Letter.all
  end

  def show
  end

  def new
    @letter = Letter.new
  end

  def edit
  end

  def deliver
    users = params[:all] ? User.all : User.where(email: params[:letter][:email])

    unique = letter_params[:unique_send].to_bool

    users.each do |user|
      unless unique && Ahoy::Message.exists?(user_id: user.id, letter_id: @letter.id)
        LetterMailer.prepare(@letter.id, user.email).deliver_later
      end
    end
    render text: "OK"
  end

  def create
    @letter = Letter.new(letter_params)

    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @letter.update(letter_params)
        format.html { redirect_to @letter, notice: 'Letter was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @letter.destroy
    respond_to do |format|
      format.html { redirect_to letters_url, notice: 'Letter was successfully destroyed.' }
    end
  end

  private
    def set_letter
      @letter = Letter.find(params[:id])
    end

    def letter_params
      params.require(:letter).permit(:subject, :body, :done, :unique_send)
    end
end
