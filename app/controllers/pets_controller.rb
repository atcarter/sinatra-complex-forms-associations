class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    # @pet = Pet.create(params[name: params["pet[name]", owner_id: params["pet[owner_id]"])
    # binding.pry
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"])
      @pet = Pet.create(name: params[:pet][:name], owner_id: @owner.id)
      @owner.pets << @pet
    else
      @owner = Owner.find_by_id(params["pet"]["owner_id"])
      @pet = Pet.create(name: params[:pet][:name], owner_id: @owner.id)
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
    # end
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owners.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    @owners = Owner.all
    erb :'/pets/show'
  end

  patch '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end