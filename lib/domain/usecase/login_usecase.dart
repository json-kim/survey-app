import 'package:survey_app/domain/model/member/member.dart';
import 'package:survey_app/domain/repository/member_repository.dart';

import 'usecase.dart';

class LoginUseCase implements UseCase<bool, Member> {
  final MemberRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<bool> call(Member member) async {
    final result = await _repository.login(member);

    return result;
  }
}
