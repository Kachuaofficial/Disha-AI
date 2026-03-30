import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResumeUploadPage extends StatefulWidget {
  const ResumeUploadPage({super.key});

  @override
  State<ResumeUploadPage> createState() => _ResumeUploadPageState();
}

class _ResumeUploadPageState extends State<ResumeUploadPage> {
  static const _allowedExtensions = ['pdf', 'doc', 'docx'];
  static const _maxFileSizeBytes = 5 * 1024 * 1024;

  PlatformFile? file;
  bool isUploading = false;
  bool hasUploadedResume = false;
  String? errorMessage;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
      withData: false,
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return;

    final selectedFile = result.files.first;
    final extension = selectedFile.extension?.toLowerCase();

    if (extension == null || !_allowedExtensions.contains(extension)) {
      setState(() {
        errorMessage = 'Please select a PDF, DOC, or DOCX file.';
      });
      return;
    }

    if (selectedFile.size > _maxFileSizeBytes) {
      setState(() {
        errorMessage = 'Resume must be smaller than 5 MB.';
      });
      return;
    }

    setState(() {
      file = selectedFile;
      hasUploadedResume = false;
      errorMessage = null;
    });
  }

  Future<void> uploadFile() async {
    if (file == null || isUploading) return;

    setState(() {
      isUploading = true;
      errorMessage = null;
    });

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    setState(() {
      isUploading = false;
      hasUploadedResume = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${file!.name} added successfully'),
      ),
    );
  }

  void removeFile() {
    setState(() {
      file = null;
      hasUploadedResume = false;
      errorMessage = null;
      isUploading = false;
    });
  }

  String _formatFileSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    if (bytes >= 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '$bytes B';
  }

  @override
  Widget build(BuildContext context) {
    final selectedFile = file;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Upload Resume'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Add Your Resume',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose a resume from your phone to unlock personalized insights and a smoother setup experience.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 28),
              InkWell(
                onTap: pickFile,
                borderRadius: BorderRadius.circular(24),
                child: Ink(
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: hasUploadedResume
                          ? const Color(0xFFA8E6A3)
                          : Colors.grey.shade300,
                      width: 1.2,
                    ),
                  ),
                  child: selectedFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 44,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Tap to choose from your phone',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Accepted: PDF, DOC, DOCX up to 5 MB',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: hasUploadedResume
                                    ? const Color(0xFFA8E6A3)
                                    : Colors.white,
                                child: Icon(
                                  hasUploadedResume
                                      ? Icons.check
                                      : Icons.insert_drive_file_outlined,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                selectedFile.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _formatFileSize(selectedFile.size),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                hasUploadedResume
                                    ? 'Resume added successfully'
                                    : 'Ready to upload',
                                style: TextStyle(
                                  color: hasUploadedResume
                                      ? Colors.green.shade700
                                      : Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 13,
                  ),
                ),
              ],
              if (selectedFile != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone_android,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Selected from phone storage',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: isUploading ? null : pickFile,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text('Replace'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: isUploading ? null : removeFile,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text('Remove'),
                      ),
                    ),
                  ],
                ),
              ],
              const Spacer(),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedFile != null
                        ? const Color(0xFFA8E6A3)
                        : Colors.grey.shade300,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: selectedFile != null && !isUploading
                      ? uploadFile
                      : null,
                  child: isUploading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          hasUploadedResume ? 'Resume Added' : 'Upload Resume',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text(
                  'Skip for now',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your data is secure and private',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
