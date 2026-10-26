import 'package:flutter/material.dart';
import '../models/recycling_step.dart';

/// The authoritative dataset of the 6 core recycling steps in EcoSteps.
const List<RecyclingStep> kRecyclingSteps = [
  RecyclingStep(
    stepNumber: 1,
    title: 'Collect Waste',
    shortDescription:
        'Gather recyclable items like paper, cardboard, plastic, glass, and metal around your home.',
    detailedInstruction:
        'Set up dedicated recycling receptacles in high-activity areas of your home or workplace. '
        'Systematically collect household recyclables: clean paper, corrugated cardboard, rigid plastic bottles and jugs, '
        'glass jars and bottles, and metal food and drink cans. '
        'Keeping recyclables separated from general household garbage at the point of origin prevents wet organic waste from ruining recoverable fibers and surfaces.',
    practicalTip:
        'Place a recycling bin directly beside your regular trash can. Proximity is the single most effective factor in preventing recyclable items from accidentally entering landfill waste.',
    icon: Icons.delete_sweep_rounded,
    heroTag: 'recycling_step_hero_1',
    category: 'Collection',
    accentColor: Color(0xFF10B981), // Emerald
    keyItems: [
      'Cardboard shipping boxes',
      'Newspapers & office paper',
      'PET & HDPE plastic containers',
      'Aluminum beverage cans',
      'Steel food cans & tins',
      'Glass bottles and jars',
    ],
    doNotInclude: [
      'Soiled food containers & napkins',
      'Plastic grocery bags & film',
      'Styrofoam / polystyrene foam',
      'Household batteries & electronics',
    ],
  ),
  RecyclingStep(
    stepNumber: 2,
    title: 'Separate Materials',
    shortDescription:
        'Segregate recyclables into distinct categories: paper, plastics, glass, and metals.',
    detailedInstruction:
        'Different raw materials undergo entirely distinct recycling cycles—paper is repulped in water, '
        'glass is crushed into cullet and melted at extreme temperatures, and plastics are chopped and flaked according to polymer type. '
        'Separate rigid plastics by checking the resin identification code (#1 PET, #2 HDPE, #5 PP). '
        'Remove any non-recyclable parts, such as plastic film lids from yogurt cups or metal rings from glass bottles, whenever practical.',
    practicalTip:
        'Check the triangular resin identification code stamped on the bottom of plastic items. In most jurisdictions, numbers #1 and #2 are universally recyclable, while #3 through #7 require specialized regional processing.',
    icon: Icons.category_rounded,
    heroTag: 'recycling_step_hero_2',
    category: 'Separation',
    accentColor: Color(0xFF06B6D4), // Cyan
    keyItems: [
      'Paper & cardboard sorted together',
      'Rigid plastic bottles & jugs',
      'Aluminum & tin cans grouped',
      'Clear & colored glass separated',
    ],
    doNotInclude: [
      'Mixed-material packaging (e.g., chip bags)',
      'Plastic film wrapped around cardboard',
      'Hazardous chemical bottles',
      'Pesticide or motor oil jugs',
    ],
  ),
  RecyclingStep(
    stepNumber: 3,
    title: 'Clean and Dry',
    shortDescription:
        'Empty liquids, rinse off food remnants, and allow containers to air dry before binning.',
    detailedInstruction:
        'Food remnants, grease, and sugary liquids degrade recycling quality and cause whole truckloads of recyclables to be rejected. '
        'Unwashed peanut butter jars, dairy bottles, or sauce containers breed bacteria, emit foul odors, and contaminate absorbent paper and cardboard. '
        'Empty all leftover content completely, give each container a quick swish with leftover washing-up water to loosen stubborn debris, and allow it to air-dry before placing it into the recycling bin.',
    practicalTip:
        'You do not need to wash containers with pristine drinking water or run them through a dishwasher. A brief scrape with a spatula followed by a quick rinse using leftover dishwater conserves precious water while keeping recyclables clean.',
    icon: Icons.water_drop_rounded,
    heroTag: 'recycling_step_hero_3',
    category: 'Sanitization',
    accentColor: Color(0xFF3B82F6), // Blue
    keyItems: [
      'Rinsed peanut butter & condiment jars',
      'Emptied soda & juice cans',
      'Scraped yogurt & margarine tubs',
      'Dry milk cartons & drink boxes',
    ],
    doNotInclude: [
      'Greasy, cheese-stained pizza boxes',
      'Containers full of expired food or grease',
      'Damp paper or dripping wet containers',
      'Soiled paper towels or tissues',
    ],
  ),
  RecyclingStep(
    stepNumber: 4,
    title: 'Sort Correctly',
    shortDescription:
        'Match items with your municipality’s color-coded recycling bins and observe local rules.',
    detailedInstruction:
        'Recycling infrastructure varies by municipality, regional waste authority, and local Materials Recovery Facility (MRF). '
        'Check your neighborhood guidelines for bin color conventions—for example, Blue for paper/cardboard, Yellow for mixed dry packaging, and Green for glass containers. '
        'Never "wish-cycle"—placing questionable items into recycling bins hoping they will be recycled—because unaccepted items like garden hoses, wire hangers, and electronics damage high-speed sorting conveyor belts.',
    practicalTip:
        'When in doubt, consult your municipality or waste provider’s website or smartphone app. It is far better to dispose of an ambiguous item in standard refuse than to risk jamming MRF sorting machinery with rogue tanglers.',
    icon: Icons.rule_folder_rounded,
    heroTag: 'recycling_step_hero_4',
    category: 'Sorting',
    accentColor: Color(0xFF8B5CF6), // Purple
    keyItems: [
      'Correct bin color identification',
      'Adherence to municipal schedules',
      'Caps screwed securely back on plastic bottles',
      'Flattened cartons inserted neatly',
    ],
    doNotInclude: [
      'Plastic bags jammed inside recycling bins',
      'Broken window panes, mirrors, or ceramics',
      'Textiles, clothes, or shoes in standard bins',
      'Medical waste or syringes',
    ],
  ),
  RecyclingStep(
    stepNumber: 5,
    title: 'Send for Recycling',
    shortDescription:
        'Set bins curbside on scheduled collection days or deliver materials to community depots.',
    detailedInstruction:
        'Once your recyclables are clean, sorted, and ready, place your recycling bins curbside according to your local collection calendar, '
        'or drop bulk materials off at municipal recycling drop-off centers. '
        'At the Material Recovery Facility (MRF), automated optical sorters, rotating trommels, giant magnets, and eddy current separators categorize materials at incredible speeds. '
        'The separated materials are compressed into high-density bales and shipped to specialized manufacturers to be melted, pulped, or re-extruded into brand-new products.',
    practicalTip:
        'Break down and flatten all cardboard boxes before placing them into bins. This quadruples bin capacity, prevents cardboard from snagging inside automated collection truck hoppers, and cuts transport fuel emissions.',
    icon: Icons.local_shipping_rounded,
    heroTag: 'recycling_step_hero_5',
    category: 'Processing',
    accentColor: Color(0xFFF59E0B), // Amber
    keyItems: [
      'Curbside collection bin readiness',
      'Municipal depot drop-offs for bulk recyclables',
      'Cardboard flattened and bundled if required',
      'Secure bin lids to prevent windblown litter',
    ],
    doNotInclude: [
      'Overflowing bins with loose items falling out',
      'Heavy automotive scrap in residential bins',
      'E-waste in standard curbside pickup',
      'Flammable gas canisters or propane tanks',
    ],
  ),
  RecyclingStep(
    stepNumber: 6,
    title: 'Reuse and Reduce',
    shortDescription:
        'Embrace circular consumption: minimize single-use packaging and repurpose everyday goods.',
    detailedInstruction:
        'While recycling is crucial, the greenest item is the one that was never manufactured in the first place. '
        'Adopt the zero-waste hierarchy: Refuse unnecessary single-use items, Reduce daily consumption, '
        'Reuse glass jars and canvas tote bags, Repurpose materials creatively, and finally Recycle what remains. '
        'By purchasing products in refillable packaging, buying concentrated cleaners, and choosing second-hand alternatives, '
        'you close the circular economy loop and conserve valuable natural resources for generations to come.',
    practicalTip:
        'Keep reusable grocery totes, stainless steel beverage flasks, and produce mesh bags in your backpack or vehicle so you are always equipped to decline single-use plastics when shopping.',
    icon: Icons.all_inclusive_rounded,
    heroTag: 'recycling_step_hero_6',
    category: 'Circular Lifestyle',
    accentColor: Color(0xFF10B981), // Emerald Leaf
    keyItems: [
      'Durable multi-use shopping bags',
      'Refillable glass storage canisters',
      'Stainless steel or silicone water bottles',
      'Upcycled garden planters from tins/jars',
    ],
    doNotInclude: [
      'Single-use plastic cutlery and straws',
      'Excessively plastic-wrapped produce',
      'Disposable coffee cups with plastic linings',
      'Throwaway lifestyle habits',
    ],
  ),
];
