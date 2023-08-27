class Pulic::TagsearchesController < ApplicationController
  def search
    @model = Item  #search機能とは関係なし
    @word = params[:content]
    @books = Item.where("category LIKE?","%#{@word}%")
    render "tagsearches/tagsearch"
  end
end
