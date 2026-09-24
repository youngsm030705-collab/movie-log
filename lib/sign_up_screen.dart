import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool agreeToTerms = false;

  // 에러 상태 (이미지 2의 붉은 배경 및 에러 테두리 표시용)
  bool isNicknameError = false;
  bool isEmailError = false;
  bool isPasswordError = false;

  @override
  void dispose() {
    nicknameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  // 각 필드 유효성 검사 조건
  bool get isNicknameValid => nicknameController.text.trim().length >= 2;
  bool get isEmailValid =>
      emailController.text.contains('@') && emailController.text.contains('.');
  bool get isPasswordValid => passwordController.text.length >= 8;

  // 가입하기 버튼 활성화 조건
  bool get canSubmit =>
      isNicknameValid && isEmailValid && isPasswordValid && agreeToTerms;

  // 메인 바이올렛 컬러 정의
  static const Color primaryViolet = Color(0xFF6B5693);
  static const Color disabledViolet = Color(0xFFD0C7E3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // 바탕 아이보리 배경색
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text(
          '회원가입',
          style: TextStyle(
            color: primaryViolet,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxFormWidth = constraints.maxWidth >= 700
                ? 560.0
                : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxFormWidth),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        // 상단 환영 문구
                        const Text(
                          '환영합니다!\n간단한 정보만 입력하고 시작해보세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF4A4A4A),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // 1. 닉네임
                        _buildLabel('닉네임'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: nicknameController,
                          textInputAction: TextInputAction.next,
                          decoration: _buildInputDecoration(
                            hintText: '닉네임을 입력해주세요',
                            isValid: isNicknameValid,
                            hasError: isNicknameError,
                          ),
                          validator: (value) {
                            final text = value?.trim() ?? '';
                            if (text.length < 2) {
                              setState(() => isNicknameError = true);
                              return '닉네임은 2자 이상이어야 합니다.';
                            }
                            setState(() => isNicknameError = false);
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              isNicknameError = false;
                            });
                          },
                          onFieldSubmitted: (_) =>
                              emailFocusNode.requestFocus(),
                        ),
                        const SizedBox(height: 20),

                        // 2. 이메일
                        _buildLabel('이메일'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: emailController,
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: _buildInputDecoration(
                            hintText: '이메일 주소를 입력해주세요',
                            isValid: isEmailValid,
                            hasError: isEmailError,
                          ),
                          validator: (value) {
                            final text = value?.trim() ?? '';
                            if (!text.contains('@') || !text.contains('.')) {
                              setState(() => isEmailError = true);
                              return '올바른 이메일 형식이 아닙니다.';
                            }
                            setState(() => isEmailError = false);
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              isEmailError = false;
                            });
                          },
                          onFieldSubmitted: (_) =>
                              passwordFocusNode.requestFocus(),
                        ),
                        const SizedBox(height: 20),

                        // 3. 비밀번호
                        _buildLabel('비밀번호'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          obscureText: true,
                          decoration: _buildInputDecoration(
                            hintText: '비밀번호를 입력해주세요',
                            isValid: isPasswordValid,
                            hasError: isPasswordError,
                          ),
                          validator: (value) {
                            final text = value ?? '';
                            if (text.length < 8) {
                              setState(() => isPasswordError = true);
                              return '비밀번호는 8자 이상이어야 합니다.';
                            }
                            setState(() => isPasswordError = false);
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              isPasswordError = false;
                            });
                          },
                        ),
                        const SizedBox(height: 36),

                        // 필수 약관 동의 체크박스
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: agreeToTerms,
                                activeColor: primaryViolet,
                                checkColor: Colors.white,
                                side: const BorderSide(
                                  color: Color(0xFFC4C4C4),
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    agreeToTerms = value ?? false;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              '필수 약관에 동의합니다',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // 가입하기 버튼
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryViolet,
                              disabledBackgroundColor:
                                  disabledViolet, // 비활성화 색상
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: canSubmit
                                ? () {
                                    final isValid =
                                        formKey.currentState?.validate() ??
                                        false;
                                    if (!isValid) return;
                                    FocusScope.of(context).unfocus();
                                  }
                                : () {
                                    // 버튼 클릭 시 Validation 에러 문구 표시
                                    formKey.currentState?.validate();
                                  },
                            child: const Text(
                              '가입하기',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // 하단 로그인
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '이미 계정이 있나요? ',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                '로그인',
                                style: TextStyle(
                                  color: primaryViolet,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 라벨 텍스트 스타일
  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // 사진과 완벽 일치하는 InputDecoration 생성기
  InputDecoration _buildInputDecoration({
    required String hintText,
    required bool isValid,
    required bool hasError,
  }) {
    // 우측 아이콘 설정
    Widget? suffixIcon;
    if (hasError) {
      suffixIcon = const Icon(
        Icons.error_outline,
        color: Color(0xFFD32F2F),
      ); // 이미지2 에러 아이콘[cite: 2]
    } else if (isValid) {
      suffixIcon = const Icon(
        Icons.check_circle,
        color: primaryViolet,
      ); // 이미지3 완료 아이콘[cite: 3]
    }

    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
      filled: true,
      // 에러 발생 시 연분홍 배경, 평소엔 밝은 베이지회색[cite: 1, 2]
      fillColor: hasError ? const Color(0xFFFDE8E8) : const Color(0xFFF5F3EF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      suffixIcon: suffixIcon,
      errorStyle: const TextStyle(
        color: Color(0xFFD32F2F),
        fontSize: 12,
        height: 1.2,
      ),
      // 기본 테두리[cite: 1]
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE0DED9), width: 1),
      ),
      // 포커스 상태[cite: 1]
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryViolet, width: 1.5),
      ),
      // 에러 발생 시 테두리 (이미지2)[cite: 2]
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE57373), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.5),
      ),
    );
  }
}
