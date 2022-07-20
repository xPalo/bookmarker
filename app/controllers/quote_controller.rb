class QuoteController < ApplicationController
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to root_url, notice: "Quote saved" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:language_code, :content, :url, :published_at)
  end
end