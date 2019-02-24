class DocumentsController < ApplicationController
  require 'digest'
  require "openssl"

  before_action :set_document, only: [:show, :edit, :update, :destroy]


  def index
      @user = current_user.id
      @documents = Document.where("user_id = ?", @user)
      if @documents.length == 0
        flash[:alert] = "You have not added any document to our service."
        redirect_to root_path
      end

  end

  def show
  end

  def new
    @document = current_user.documents.build
  end

  def edit
  end


  def create
    @document = current_user.documents.create(document_params)
    @document.save
    @document_string = (@document.as_json).to_s

    @hash_value = Digest::SHA256.hexdigest @document_string
    # @document.update(hash_document: @hash_value)
    redirect_to documents_path
    # raise
  end



  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :hash_document, :user_id, :attached_document)
    end
  end
