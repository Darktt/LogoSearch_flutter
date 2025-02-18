enum LogoImageFallback implements Comparable<LogoImageFallback> {
  monogram('Monogram (Default)'),
  notFound('Not Found');

  final String description;

  const LogoImageFallback(this.description);

  @override
  int compareTo(LogoImageFallback other) =>
      description.compareTo(other.description);
}
