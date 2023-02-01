import { expect, describe, it } from '@jest/globals';
import './jest_extensions';

describe('Part 1 - Query 12', () => {
  it('should return the correct closest results', async () => {
    await expect('../part1/query12.sql')
      .toReturnRecords([
        'expected_results/part1/query12.csv',
        'expected_results/part1/query12alt1.csv',
        'expected_results/part1/query12alt2.csv',
      ]);
  });
});