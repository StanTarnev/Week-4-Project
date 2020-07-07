class RouteHelper
  def self.filter_out_conflicting_gym_classes(all_gym_classes_array, current_member_hash)
    gym_classes_with_available_places = []
    for gym_class in all_gym_classes_array
      if gym_class.capacity > gym_class.members.length
        gym_classes_with_available_places.push(gym_class)
      end
    end

    gym_classes_not_conflicting_in_time_slot = []
    for gym_class in gym_classes_with_available_places
      if current_member_hash.gym_classes.length > 0
        gym_classes_conflicting_in_time_slot = []
        current_member_hash.gym_classes.each do |current_member_gym_class|
          if current_member_gym_class.time_slot == gym_class.time_slot
            gym_classes_conflicting_in_time_slot.push(gym_class)
          end
        end
        if gym_classes_conflicting_in_time_slot.length < 1
          gym_classes_not_conflicting_in_time_slot.push(gym_class)
        end
      else
        gym_classes_not_conflicting_in_time_slot.push(gym_class)
      end
    end

    class_cannot_be_enrolled = []
    gym_classes_not_conflicting = []
    for gym_class in gym_classes_not_conflicting_in_time_slot
      if gym_class.premium_time_slot_check && !current_member_hash.premium_membership
        class_cannot_be_enrolled.push(gym_class)
      else
        gym_classes_not_conflicting.push(gym_class)
      end
    end
    return gym_classes_not_conflicting
  end
end
