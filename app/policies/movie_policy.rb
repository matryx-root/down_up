class MoviePolicy < ApplicationPolicy
      class Scope < Scope
            def resolve
                scope.where(user: user)

            end
      end

      def show?
        return true
      end

      def create?
        return true
      end

      def update?
        record.user == user || user.admin?
      end

      def destroy?
        record.user == user || user.admin?
      end


end
