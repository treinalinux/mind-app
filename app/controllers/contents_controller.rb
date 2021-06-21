# frozen_string_literal: true

# class ContentsController
class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content, only: %i[show edit destroy update]

  def index
    @contents = current_user.contents
  end

  def new
    @content = Content.new
  end

  def show; end

  def edit; end

  def destroy
    @content.destroy

    redirect_to contents_path, notice: 'Content successfully destroyed!'
  end

  def update
    if @content.update(content_params)
      tags = tags_params.map do |tag_name|
        current_user.tags.where(name: tag_name).first_or_initialize
      end

      @content.tags = tags

      redirect_to contents_path, notice: 'Content successfully updated!'
    else
      render :edit
    end
  end

  def create
    @content = current_user.contents.build(content_params)

    if @content.save
      redirect_to contents_path, notice: 'Content successfully created!'
    else
      render :new
    end
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end

  def tags_params
    params.require(:content).permit(tags: [])[:tags].reject(&:blank?)
  end

  def content_params
    params.require(:content).permit(:title, :description)
  end
end
