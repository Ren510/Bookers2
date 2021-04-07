  class RelationshipsController < ApplicationController
    def follow
      user = User.find(params[:id])
      current_user.follow(user)
      redirect_to request.referer
      # if followers.save
      #   redirect_to request.referer
      # else
      #   redirect_to request.referer
      # end
    end

    def unfollow
      @users = User.find(params[:id])
      followers = current_user.unfollow(@users)
      if followers.destroy
        redirect_to request.referer
      else
        redirect_to request.referer
      end
    end

    private
    def users_params
      @users = User.find(params[:followed_id][:follower_id])
    end
  end