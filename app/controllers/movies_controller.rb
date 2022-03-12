class MoviesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]

before_action :set_movie, only: %w[show edit update destroy admin_list]

      def admin_list
        authorize @movie
      end


      #READ
      #get all
      def index
         if params[:query].present?

         @movies = policy_scope(Movie).where("lower(title)  LIKE ?", "%" + params[:query].downcase + "%")
        else

         @movies = policy_scope(Movie).order(created_at: :desc)
        end
      end


        #get/:id (individual)
        def show; end




        #CREATE
        #get new formulario(aun no tiene id)
        def new
        @movie = Movie.new
        authorize @movie
        end



        #post render a new
        def create
        @movie = Movie.new(movies_params)
        @movie.user = current_user
        authorize @movie
            if @movie.save
              redirect_to movies_path(@movie)
            else
              render :new
            end
        end





      #UPDATE
      #get/:id/edit formulario
      def edit; end

        #patch(put)/:id render a edit
      def update

            if @movie.update(movies_params)
              redirect_to root_path(@movies)
            else
              render :edit
            end
      end





        #DELETE
        #delete/:id
        def destroy

          @movie.destroy
          redirect_to movies_path

        end




          private

          def movies_params
            params.require(:movie).permit(:image, :title, :genre, :description, :rating)

          end

          def set_movie
          @movie = Movie.find(params[:id])
          authorize @movie
          end
end
