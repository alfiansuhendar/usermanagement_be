class Api::V1::UsersController < ApplicationController
    before_action :getUser, only: [:updateUser, :deleteUser, :showUser]

    #get
    def getUsers
        user = User.all
        if user
            render json: user, status: :ok
        else
            render json: { msg: "User Empty" }, status: :unprocessable_entity
        end
    end

    #post
    def addUser
        user = User.new(userparams)
        user.type = 2; #everytime a user is created a type is will be dafault as 2

        if user.save()
            render json: user, status: :ok
        else
            render json: { msg: "User not added", error: user.errors }, status: :unprocessable_entity
        end
    end

    #show
    def showUser
        if @user
            render json: @user, status: :ok
        else
            render json: { msg: "User not Found" }, status: :unprocessable_entity
        end
    end

    #put
    def updateUser
        if @user
            if @user.update(userparams)
                render json: @user, status: :ok
            else
                render json: { msg: "Update Failed", error: @user.errors }, status: :unprocessable_entity
            end
        else
            render json: { msg: "User not Found" }, status: :unprocessable_entity
        end
    end

    #delete
    def deleteUser
        if @user
            if @user.destroy()
                render json: { msg:"User deleted" }, status: :ok
            else
                render json: { msg:"Deleted Failed" }, status: :unprocessable_entity
            end
        else
            render json: { msg: "User not Found" }, status: :unprocessable_entity
        end
    end

    private
        def userparams
            params.permit(:username, :email, :password);
        end

        def getUser
            @user = User.find(params[:id])
        end
end
