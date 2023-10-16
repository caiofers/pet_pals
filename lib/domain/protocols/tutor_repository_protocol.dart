abstract interface class TutorRepositoryProtocol {
  Future<void> add(
    String id,
    String name,
    String? avatarUrl,
  );

  Future<void> addPetToTutor(
    String tutorId,
    String petId,
  );

  Future<void> removePetFromTutor(
    String tutorId,
    String petId,
  );

  Future<List<String>> getPetIdsFromTutor(String tutorId);

  Future<void> addAlarmToTutor(
    String tutorId,
    String alarmId,
  );

  Future<void> removeAlarmFromTutor(
    String tutorId,
    String alarmId,
  );

  Future<List<String>> getAlarmIdsFromTutor(String tutorId);
}
