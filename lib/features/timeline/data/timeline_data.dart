import '../domain/era.dart';
import '../domain/timeline_entry.dart';

const bool kStressTest = bool.fromEnvironment('STRESS');

final List<TimelineEntry> timelineEntries = kStressTest
    ? _stressEntries()
    : _realEntries;

List<TimelineEntry> _stressEntries() {
  return List.generate(
    500,
        (i) => TimelineEntry(
      id: 'stress-$i',
      title: i % 50 == 0 ? 'Long title ' * 14 : 'Test event #$i',
      era: Era.values[i * 3 ~/ 500],
      year: i - 250,
      mediaType: MediaType.values[i % MediaType.values.length],
      summary: 'Long summary to test overflow. ' * 20,
    ),
  );
}

const _realEntries = <TimelineEntry>[
  // ── Prequel Era ──
  TimelineEntry(
    id: 'naboo-blockade',
    title: "Blockade of Naboo",
    era: Era.prequel,
    year: -32,
    mediaType: MediaType.film,
    summary: "The Trade Federation blockades the planet Naboo under the secret manipulation of Darth Sidious. Qui-Gon Jinn and Obi-Wan Kenobi are sent to resolve the conflict.",
  ),
  TimelineEntry(
    id: 'anakin-discovery',
    title: "Discovery of Anakin Skywalker",
    era: Era.prequel,
    year: -32,
    mediaType: MediaType.film,
    summary: "Stranded on Tatooine, Qui-Gon discovers Anakin Skywalker, a slave with the highest midi-chlorian count ever recorded.",
  ),
  TimelineEntry(
    id: 'battle-of-naboo',
    title: "Battle of Naboo",
    era: Era.prequel,
    year: -32,
    mediaType: MediaType.film,
    summary: "The Gungan and Naboo forces fight the Trade Federation. Darth Maul kills Qui-Gon Jinn before finally being defeated by Obi-Wan Kenobi.",
  ),
  TimelineEntry(
    id: 'clone-wars-begin',
    title: "Start of the Clone Wars",
    era: Era.prequel,
    year: -22,
    mediaType: MediaType.film,
    summary: "The Battle of Geonosis erupts. The Republic's secretly ordered Clone Army is deployed to fight the Separatist droids led by Count Dooku.",
  ),
  TimelineEntry(
    id: 'secret-wedding',
    title: "Secret Wedding",
    era: Era.prequel,
    year: -22,
    mediaType: MediaType.film,
    summary: "Anakin Skywalker and Padmé Amidala marry in secret on Naboo, violating the Jedi code that forbids emotional attachment.",
  ),
  TimelineEntry(
    id: 'chancellor-rescue',
    title: "Rescue of the Chancellor",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Anakin kills Count Dooku at the urging of Chancellor Palpatine during a rescue mission above the capital city of Coruscant.",
  ),
  TimelineEntry(
    id: 'anakin-fall',
    title: "The Fall of Anakin",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Haunted by visions of Padmé's death, Anakin submits to Darth Sidious to learn the dark side and is made Darth Vader.",
  ),
  TimelineEntry(
    id: 'order-66',
    title: "Execution of Order 66",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Palpatine issues a secret command that makes the Clone troopers betray and slaughter the Jedi across the galaxy.",
  ),
  TimelineEntry(
    id: 'mustafar-duel',
    title: "Duel on Mustafar",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Obi-Wan defeats Darth Vader in an epic duel. The severely burned Vader is rescued and placed inside a life-support suit of armor.",
  ),
  TimelineEntry(
    id: 'twins-born',
    title: "Birth of the Twins",
    era: Era.prequel,
    year: -19,
    mediaType: MediaType.film,
    summary: "Padmé dies after giving birth to Luke and Leia. The two are separated; Luke is taken to Tatooine and Leia is adopted by the royal family of Alderaan.",
  ),

  // ── Original Trilogy ──
  TimelineEntry(
    id: 'death-star-plans',
    title: "Theft of the Death Star Plans",
    era: Era.original,
    year: 0,
    mediaType: MediaType.film,
    summary: "The Rebels manage to steal the blueprints of the Empire's secret weapon, the Death Star, and hide them inside the droid R2-D2.",
  ),
  TimelineEntry(
    id: 'battle-of-yavin',
    title: "Battle of Yavin",
    era: Era.original,
    year: 0,
    mediaType: MediaType.film,
    summary: "Guided by the Force and the spirit of Obi-Wan, Luke Skywalker fires the proton torpedoes that destroy the first Death Star.",
  ),
  TimelineEntry(
    id: 'battle-of-hoth',
    title: "Battle of Hoth",
    era: Era.original,
    year: 3,
    mediaType: MediaType.film,
    summary: "The Empire attacks the Rebels' secret base on the ice planet Hoth with a fleet of AT-ATs, forcing the Rebels to flee.",
  ),
  TimelineEntry(
    id: 'cloud-city-reveal',
    title: "Revelation at Cloud City",
    era: Era.original,
    year: 3,
    mediaType: MediaType.film,
    summary: "In a lightsaber duel, Darth Vader cuts off Luke's hand and reveals a dark truth: 'I am your father'.",
  ),
  TimelineEntry(
    id: 'han-solo-rescue',
    title: "Rescue of Han Solo",
    era: Era.original,
    year: 4,
    mediaType: MediaType.film,
    summary: "Luke, Leia, and their friends infiltrate Jabba the Hutt's palace on Tatooine to rescue Han Solo, who is frozen in carbonite.",
  ),
  TimelineEntry(
    id: 'battle-of-endor',
    title: "Battle of Endor",
    era: Era.original,
    year: 4,
    mediaType: MediaType.film,
    summary: "The Rebels destroy the second Death Star's shield generator with the help of the Ewok tribe on the forest moon of Endor.",
  ),
  TimelineEntry(
    id: 'vader-redemption',
    title: "Redemption of Darth Vader",
    era: Era.original,
    year: 4,
    mediaType: MediaType.film,
    summary: "Unable to bear watching Luke be tortured by Palpatine, Vader sacrifices his life by throwing the Emperor into the reactor. The Empire collapses.",
  ),

  // ── Sequel Era ──
  TimelineEntry(
    id: 'first-order-rise',
    title: "Rise of the First Order",
    era: Era.sequel,
    year: 34,
    mediaType: MediaType.film,
    summary: "The remnants of the Empire form the First Order. Starkiller Base destroys the Hosnian system, the capital of the New Republic.",
  ),
  TimelineEntry(
    id: 'luke-sacrifice',
    title: "Luke's Sacrifice",
    era: Era.sequel,
    year: 34,
    mediaType: MediaType.film,
    summary: "Luke projects himself to the planet Crait to hold off Kylo Ren, buying the Rebels time to escape, before becoming one with the Force.",
  ),
  TimelineEntry(
    id: 'sith-destruction',
    title: "Destruction of the Sith",
    era: Era.sequel,
    year: 35,
    mediaType: MediaType.film,
    summary: "Rey Skywalker and Ben Solo unite on Exegol. Rey turns Palpatine's lightning back on him, destroying the Emperor and the Final Order for good.",
  ),
];