class ReviewsController < ApplicationController
  before_action :set_movie, only: [:new, :create ]



  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    @review.movie = @movie
    #@movie.user = current_user
    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

   def edit
    @review = Review.find(params[:id])
    authorize @review
    end

        #patch(put)/:id render a edit
      def update
        @review = Review.find(params[:id])
        authorize @review
          if @review.update(review_params)
              redirect_to movie_path(@review.movie)
            else
              render :edit
            end
      end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to movie_path(@review.movie)
  end






    private

    def set_movie
      @movie = Movie.find(params[:movie_id])
      authorize @movie
    end

    def review_params
      params.require(:review).permit(:image, :title, :rating, :content)

    end

end
