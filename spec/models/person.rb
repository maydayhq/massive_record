class Person < MassiveRecord::ORM::Table
  #validates_presence_of :first_name, :last_name, :email
  #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  #column_family :info do
    #field :first_name
    #field :last_name
    #field :email
    #field :date_of_birth, Date
    #field :status, Boolean, :default => false
  #end
  
  #def name
    #"#{first_name} #{last_name}"
  #end
  
  #def active?
    #status == 1
  #end
end
