abstract interface class TutorRepositoryProtocol {
  Future<void> add(
    String id,
    String name,
    String? avatarUrl,
    List<String> petIds,
  );

  Future<void> addPetToTutor(
    String tutorId,
    String petId,
  );

  Future<void> removePetFromTutor(
    String tutorId,
    String petId,
  );
  Future<List<String>> getTutorPetIds(String tutorId);
}
