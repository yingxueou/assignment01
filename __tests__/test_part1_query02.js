import { expect, describe, it } from '@jest/globals';
import './jest_extensions';

describe('Part 1 - Query 02', () => {
  it('should return the correct results', async () => {
    await expect('../part1/query02.sql')
      .toReturnRecords([
        'expected_results/part1/query02.csv',
        'expected_results/part1/query02_alt.csv',
      ]);
  });
});