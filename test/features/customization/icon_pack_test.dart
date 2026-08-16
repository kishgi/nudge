import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/core/theme/nudge_icons.dart';

void main() {
  group('NudgeIconResolver tests', () {
    const settings = NudgeIconSettings(
      pack: NudgeIconPack.material,
      size: 20.0,
      thickness: 1.5,
      style: 'outline',
      colorOverride: null,
      opacity: 1.0,
    );

    test('MaterialIconResolver maps all tokens successfully', () {
      const resolver = MaterialIconResolver();
      expect(resolver.pack, NudgeIconPack.material);
      for (final token in NudgeIconToken.values) {
        final icon = resolver.resolve(token);
        expect(icon, isNotNull);
        expect(icon.fontFamily, 'MaterialIcons');
      }
    });

    test('LucideIconResolver maps all tokens successfully', () {
      const resolver = LucideIconResolver();
      expect(resolver.pack, NudgeIconPack.lucide);
      for (final token in NudgeIconToken.values) {
        final icon = resolver.resolve(token);
        expect(icon, isNotNull);
      }
    });

    test('PhosphorIconResolver maps all tokens successfully', () {
      const resolver = PhosphorIconResolver(1.5, 'outline');
      expect(resolver.pack, NudgeIconPack.phosphor);
      for (final token in NudgeIconToken.values) {
        final icon = resolver.resolve(token);
        expect(icon, isNotNull);
      }
    });

    test('TablerIconResolver maps all tokens successfully', () {
      const resolver = TablerIconResolver();
      expect(resolver.pack, NudgeIconPack.tabler);
      for (final token in NudgeIconToken.values) {
        final icon = resolver.resolve(token);
        expect(icon, isNotNull);
        expect(icon.fontFamily, 'TablerIcons');
      }
    });

    test('RemixIconResolver maps all tokens successfully', () {
      const resolver = RemixIconResolver();
      expect(resolver.pack, NudgeIconPack.remix);
      for (final token in NudgeIconToken.values) {
        final icon = resolver.resolve(token);
        expect(icon, isNotNull);
        expect(icon.fontFamily, 'RemixIcon');
      }
    });

    test('NudgeIconResolver.forSettings factory works correctly', () {
      final materialRes = NudgeIconResolver.forSettings(settings);
      expect(materialRes.pack, NudgeIconPack.material);

      final lucideRes = NudgeIconResolver.forSettings(settings.copyWith(pack: NudgeIconPack.lucide));
      expect(lucideRes.pack, NudgeIconPack.lucide);

      final phosphorRes = NudgeIconResolver.forSettings(settings.copyWith(pack: NudgeIconPack.phosphor));
      expect(phosphorRes.pack, NudgeIconPack.phosphor);

      final tablerRes = NudgeIconResolver.forSettings(settings.copyWith(pack: NudgeIconPack.tabler));
      expect(tablerRes.pack, NudgeIconPack.tabler);

      final remixRes = NudgeIconResolver.forSettings(settings.copyWith(pack: NudgeIconPack.remix));
      expect(remixRes.pack, NudgeIconPack.remix);
    });
  });
}
