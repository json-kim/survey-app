import 'package:survey_app/domain/model/member/member.dart';

abstract class MemberRepository {
  Future<bool> login(Member member);

  Future<bool> signup(Member member);

  Future<bool> getAuth(Member member);
}
