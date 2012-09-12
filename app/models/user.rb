class User < ActiveRecord::Base

  devise(:database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable)

  attr_accessible(:email,
                  :password,
                  :password_confirmation,
                  :remember_me)

  has_one(:nbec,
          :class_name => "NbecToken",
          :dependent => :destroy)
end
