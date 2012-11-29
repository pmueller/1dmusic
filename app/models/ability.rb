class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    user ||= User.new

    can [:new, :create], Song

    can [:read, :update, :delete, :step], Song do |song|
      song.user_id == user.id
    end

    can :manage, Generation do |generation|
      generation.song.user_id == user.id 
    end

    can :manage, Rule do |rule|
      rule.song.user_id == user.id 
    end

  end
end
