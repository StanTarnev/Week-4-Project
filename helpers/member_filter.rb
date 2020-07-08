class MemberFilter
  def self.filter_out_conflicting_members(all_members_array, current_gym_class_hash)
    members_available_for_current_gym_class_time_slot = []
    for member in all_members_array
      if member.gym_classes.length > 0
        members_conflicting_in_time_slot = []
        member.gym_classes.each do |gym_class|
          if gym_class.time_slot == current_gym_class_hash.time_slot
            members_conflicting_in_time_slot.push(member)
          end
        end
        if members_conflicting_in_time_slot.length < 1
          members_available_for_current_gym_class_time_slot.push(member)
        end
      else
        members_available_for_current_gym_class_time_slot.push(member)
      end
    end

    members_cannot_enroll = []
    members_passing_requirements_for_time_slot = []
    for member in members_available_for_current_gym_class_time_slot
      if !member.premium_membership && current_gym_class_hash.premium_time_slot_check
        members_cannot_enroll.push(member)
      else
        members_passing_requirements_for_time_slot.push(member)
      end
    end
    return members_passing_requirements_for_time_slot
  end
end
