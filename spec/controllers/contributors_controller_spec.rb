require 'rails_helper'

# TODO use FactoryGirl to simplify the data setup.
RSpec.describe ContributorsController do

  describe "POST create" do

    it "creates a team and a contributor" do
      post :create, params: {"Team" => "Daltons", "Name" => "Joe"}

      daltons = Team.find_by(name: "Daltons")
      expect(daltons).not_to be_nil

      joe = Contributor.find_by(name: "Joe", team: daltons)
      expect(joe).not_to be_nil
    end

    it "redirects to the contributor" do
      post :create, params: {"Team" => "Mogwai", "Name" => "Gyzmo"}

      mogwai = Team.find_by(name: "Mogwai")
      gyzmo = Contributor.find_by(name: "Gyzmo", team: mogwai)

      expect(response).to redirect_to(contributor_path(gyzmo))
    end

    it "reuses existing teams by name" do
      daltons = Team.create(name: "Daltons")

      post :create, params: {"Team" => "Daltons", "Name" => "Joe"}

      joe = Contributor.find_by(name: "Joe", team: daltons)

      expect(response).to redirect_to(contributor_path(joe))
    end

    it "reuses existing contributors by name and team" do
      daltons = Team.create(name: "Daltons")
      joe = Contributor.create(name: "Joe", team: daltons)

      post :create, params: {"Team" => "Daltons", "Name" => "Joe"}

      expect(response).to redirect_to(contributor_path(joe))
    end

    it "assigns the animator if there was none" do
      post :create, params: {"Team" => "Daltons", "Name" => "Joe"}

      daltons = Team.find_by(name: "Daltons")
      expect(daltons.animator.name).to eq("Joe")
    end

    # TODO move to an hexagonal architecture in order to encapsulate team.animator= this would ensure a unique way to update the animator, and we could remove this almost duplicated test https://medium.com/@vsavkin/hexagonal-architecture-for-rails-developers-8b1fee64a613#.c2giyb3mh
    it "does not change the animator if there is already one" do
      daltons = Team.create(name: "Daltons")
      joe = Contributor.create(name: "Joe", team: daltons)
      daltons.animator = joe
      daltons.save

      post :create, params: {"Team" => "Daltons", "Name" => "Avrel"}

      expect(Team.find_by(name: "Daltons").animator).to eq(joe)
    end

  end

  describe "GET show" do
    render_views

    it "displays the animator view if the contributor is the animator" do
      daltons = Team.create(name: "Daltons")
      joe = Contributor.create(name: "Joe", team: daltons)
      daltons.update(animator: joe)

      get :show, params: { id: joe }

      expect(response.body).to include("animator").and include("Daltons").and include("Joe")
    end

    it "displays the voter view otherwise" do
      daltons = Team.create(name: "Daltons")
      avrel = Contributor.create(name: "Avrel", team: daltons)

      get :show, params: { id: avrel }

      expect(response.body).to include("voter").and include("Daltons").and include("Avrel")
    end

  end

end
