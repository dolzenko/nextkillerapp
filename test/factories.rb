Factory.sequence :email do |n|
	"person#{n}@example.com"
end

Factory.define :message do |u|
	u.email { Factory.next(:email) }
	u.subject 'Subject text ' * 3
	u.body "Body text " * 50
end